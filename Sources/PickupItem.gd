class_name PickupItem
extends Resource

enum MushroomType {
    Poisonous,
    Health,
    Normal,
    Magical
}

@export var mushroomName : String;
@export var mushroomImage : Texture2D;
@export var mushroomType : MushroomType;
