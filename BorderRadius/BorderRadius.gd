# Pixel-sized Border Radius Shader
# Copyright (C) 2023 Oğuzhan Eroğlu <meowingcate@gmail.com> (https://oguzhaneroglu.com)

@tool

extends Control
class_name BorderRadius

@export var radius_top_left: int = 10
@export var radius_top_right: int = 10
@export var radius_bottom_left: int = 10
@export var radius_bottom_right: int = 10

var shader = preload("./BorderRadius.gdshader")

@onready var shader_material = ShaderMaterial.new()
var editor_material = null

func _ready() -> void:
	if !(get_parent() is CanvasItem):
		return
	
	get_parent().set_owner(get_tree().edited_scene_root)
	
	shader_material.shader = shader
	get_parent().material = shader_material

func _process(_delta: float) -> void:
	var nParent = get_parent()
	
	if !(nParent is CanvasItem):
		return
	
	var parent_size: Vector2
	
	if nParent is Node2D:
		parent_size = nParent.get_rect().size
	elif nParent is TextureRect:
		parent_size = nParent.texture.get_size()
	elif nParent is Control:
		parent_size = nParent.size
	else:
		return
	
	if !shader_material:
		shader_material = ShaderMaterial.new()
		shader_material.shader = shader
		
	if !nParent.material:
		nParent.material = shader_material
	
	shader_material.set_shader_parameter("canvas_width", parent_size.x)
	shader_material.set_shader_parameter("canvas_height", parent_size.y)
	
	shader_material.set_shader_parameter("radius_top_left", radius_top_left)
	shader_material.set_shader_parameter("radius_top_right", radius_top_right)
	shader_material.set_shader_parameter("radius_bottom_left", radius_bottom_left)
	shader_material.set_shader_parameter("radius_bottom_right", radius_bottom_right)
