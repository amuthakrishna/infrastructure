# infrastructure/main.tf

module "vpc" {
  source             = "./modules/vpc"
  project_name       = var.project_name
  vpc_cidr           = var.vpc_cidr
  availability_zones = var.availability_zones
  tags               = var.tags
}

module "alb" {
  source            = "./modules/alb"
  project_name      = var.project_name
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  tags              = var.tags
}

module "s3" {
  source                      = "./modules/s3"
  project_name                = var.project_name
  environment                 = var.environment
  env_s3_key                  = var.env_s3_key
  db_name                     = var.db_name
  db_username                 = var.db_username
  db_password                 = var.db_password
  aws_region                  = var.aws_region
  ecs_task_execution_role_arn = module.ecs.ecs_task_execution_role_arn
  tags                        = var.tags

  # These will be known after other modules are created
  db_host     = replace(module.rds.rds_endpoint, ":5432", "")
  lb_endpoint = module.alb.alb_dns_name
}

module "rds" {
  source                = "./modules/rds"
  project_name          = var.project_name
  vpc_id                = module.vpc.vpc_id
  db_name               = var.db_name
  db_username           = var.db_username
  db_password           = var.db_password
  db_instance_class     = var.db_instance_class
  database_subnet_ids   = module.vpc.database_subnet_ids
  ecs_security_group_id = module.ecs.ecs_security_group_id
  tags                  = var.tags
}

module "ecs" {
  source                    = "./modules/ecs"
  project_name              = var.project_name
  vpc_id                    = module.vpc.vpc_id
  private_subnet_ids        = module.vpc.private_subnet_ids
  aws_region                = var.aws_region
  ecs_task_cpu              = var.ecs_task_cpu
  ecs_task_memory           = var.ecs_task_memory
  ecs_service_desired_count = var.ecs_service_desired_count


  s3_bucket_arn         = module.s3.s3_bucket_arn
  env_file_s3_arn       = module.s3.env_file_s3_arn
  target_group_arn      = module.alb.target_group_arn
  alb_security_group_id = module.alb.alb_security_group_id
  container_image_app   = var.container_image_app
  container_image_nginx = var.container_image_nginx
  tags                  = var.tags
}