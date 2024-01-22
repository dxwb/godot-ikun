extends CanvasLayer


var smokeParticles = preload("res://scenes/VFX/smoke/smoke_particle_process.tres")
var fireworkParticles = preload("res://scenes/VFX/fireworks/fireworks_particle_process.tres")
var bloodParticles = preload("res://scenes/VFX/blood/blood_particle_process.tres")

var materials = [
	smokeParticles,
	fireworkParticles,
	bloodParticles
]

var frames = 0
var loaded = false


func _ready():
	for material in materials:
		var particles_instance = GPUParticles2D.new()
		particles_instance.set_process_material(material)
		particles_instance.set_one_shot(true)
		particles_instance.set_modulate(Color(1,1,1,0))
		particles_instance.set_emitting(true)
		self.add_child(particles_instance)

func _physics_process(_delta):
	if frames >= 3:
		set_physics_process(false)
		loaded = true
	frames += 1
