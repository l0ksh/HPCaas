output "master" {
  value = openstack_compute_instance_v2.master[*].access_ip_v4
}
