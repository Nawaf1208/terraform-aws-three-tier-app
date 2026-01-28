module "vpc" {
  source               = "./modules/vpc"
  project_name         = var.project_name
  vpc_cidr             = "10.0.0.0/16"
  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
  db_subnet_cidrs      = ["10.0.5.0/24", "10.0.6.0/24"]
  azs                  = ["us-east-1a", "us-east-1b"]
}

module "ec2" {
  source             = "./modules/ec2"
  project_name       = var.project_name
  vpc_id             = module.vpc.vpc_id
  public_subnet_ids  = module.vpc.public_subnet_ids
  private_subnet_ids = module.vpc.private_subnet_ids
  instance_type      = "t2.micro"
}

module "rds" {
  source        = "./modules/rds"
  project_name  = var.project_name
  vpc_id        = module.vpc.vpc_id
  db_subnet_ids = module.vpc.db_subnet_ids
  app_sg_id     = module.ec2.app_security_group_id
  db_username   = var.db_username
  db_password   = var.db_password
}
