require_relative 'gpu'

input = IO.read('input.txt')
gpu = Gpu.parse(input)
num = gpu.closest_particle_num
puts "The particle that will stay closest to the origin is particle #{num}"
