import os
import re
import glob

# Find directory with latest version in current directory
def find_latest_version(OS):
    all_directories = glob.glob("./Exports/" + OS + "/*")
    latest_version_major = 0
    latest_version_minor = 0
    latest_version_patch = 0

    for directory in all_directories:
        match = re.match(r"./Exports/" + OS + "[\\/\\\\](\d+)\.(\d+)\.(\d+)", directory)

        if match:
            major = int(match.group(1))
            minor = int(match.group(2))
            patch = int(match.group(3))

            if major > latest_version_major:
                latest_version_major = major
                latest_version_minor = minor
                latest_version_patch = patch
            elif major == latest_version_major:
                if minor > latest_version_minor:
                    latest_version_minor = minor
                    latest_version_patch = patch
                elif minor == latest_version_minor:
                    if patch > latest_version_patch:
                        latest_version_patch = patch

    return str(latest_version_major) + "." + str(latest_version_minor) + "." + str(latest_version_patch)


def publish_windows():
    system = "Windows"
    version = find_latest_version(system)
    itch_project = "rafazcruz/guidingstar:windows"
    command = "butler push --userversion " + version + " ./Exports/" + system + "/" + version + " " + itch_project

    print("Pushing " + system + " Build " + version + " to " + itch_project)
    print("Command: " + command)
    os.system(command)


def publish_linux():
    system = "Linux"
    version = find_latest_version(system)
    itch_project = "rafazcruz/guidingstar:linux"
    command = "butler push --userversion " + version + " ./Exports/" + system + "/" + version + " " + itch_project

    print("Pushing " + system + " Build " + version + " to " + itch_project)
    print("Command: " + command)
    os.system(command)


def publish_web():    
    system = "Web"
    version = find_latest_version("Web")
    itch_project = "rafazcruz/guidingstar:html5"
    command = "butler push --userversion " + version + " ./Exports/" + system + "/" + version + " " + itch_project

    print("Pushing Web Build " + version + " to " + itch_project)
    print("Command: " + command)
    os.system(command)

##################################################################################
##################################################################################
###################################  MAIN CODE  ##################################

publish_web()
publish_windows()
publish_linux()