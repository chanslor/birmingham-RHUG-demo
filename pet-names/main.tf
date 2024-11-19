# Initialize the random provider
provider "random" {}

# Generate multiple random pet names
resource "random_pet" "pet_names" {
  count     = 20      # Create 10 instances
  length    = 1       # Number of words in each pet name
  separator = "-"     # Character used to separate the words
}

# Output the generated pet names as a list
output "pet_names" {
  value = [for pet in random_pet.pet_names : pet.id]
}

