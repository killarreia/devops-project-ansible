module "ec2_instance" {
    source = "./modules/ec2_instance"
    public_key = var.public_key
}