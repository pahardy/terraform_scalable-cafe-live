output "alb_dns_name" {
  description = "Name of LB"
  value = module.webserver_cluster.lb_dns_name
}