class_name MushroomData
extends Resource

enum MushroomType {
    Poisonous,
    Health,
    Normal,
    Magical
}

@export var mushroomName : String;
@export var mushroomAnimations : SpriteFrames;
@export var mushroomType : MushroomType;
@export var voiceline: AudioStream;
