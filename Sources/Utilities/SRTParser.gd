extends Node

enum SRTParserState {
	NUMBER,
	TIMESTAMP,
	TEXT,
	BLANK,
	END
}

func parse_srt(text: String):
	var lines = text.split("\n")
	var subs = []
	var sub = {}
	var parser_state = SRTParserState.NUMBER
	for line in lines:
		match parser_state:
			SRTParserState.BLANK:
				if line.is_valid_int():
					parser_state = SRTParserState.NUMBER
					continue
				else:
					parser_state = SRTParserState.END
			SRTParserState.BLANK, SRTParserState.NUMBER:
				if line.is_valid_int():
					sub["number"] = line.to_int()
					parser_state = SRTParserState.TIMESTAMP
			SRTParserState.TIMESTAMP:
				var timestamp = parse_timestamp(line)
				sub['timestamp'] = timestamp
				parser_state = SRTParserState.TEXT
			SRTParserState.TEXT:
				if line == "":
					subs.append(sub)
					sub = {}
					parser_state = SRTParserState.BLANK
				else:
					if "text" in sub:
						sub["text"].append(line)
					else:
						sub["text"] = [line]

		if parser_state == SRTParserState.END:
			break
	return subs

func parse_timestamp(timestamp: String):
	var parts = timestamp.split(" --> ")
	var start = parts[0]
	var end = parts[1]
	# convert to milliseconds
	var start_parts = start.split(":")
	var end_parts = end.split(":")
	var start_milliseconds = start_parts[0].to_int() * 3600000 + start_parts[1].to_int() * 60000 + start_parts[2].to_int()
	var end_milliseconds = end_parts[0].to_int() * 3600000 + end_parts[1].to_int() * 60000 + end_parts[2].to_int()
	return {"start": start_milliseconds, "end": end_milliseconds}

