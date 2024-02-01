# Master node

resource "openstack_compute_instance_v2" "master" {
  name            = "master"
  image_name      = var.image
  flavor_name     = var.flavor
  key_pair        = var.keypair
  security_groups = [var.security_groups]
  user_data       = file("./user-data.yaml")

  network {
    name = var.private
  }

}

# Compute node

resource "openstack_compute_instance_v2" "compute" {
  name            = "cn0${count.index}"
  image_name      = var.image
  flavor_name     = var.flavor
  key_pair        = var.keypair
  security_groups = [var.security_groups]
  user_data       = file("./user-data.yaml")
  count           = var.instance_count

  network {
    name = var.private
  }
}

# Generate floating ip
/*
resource "openstack_networking_floatingip_v2" "floating_ip_master" {
  pool = "public"
}

resource "openstack_compute_floatingip_associate_v2" "floatingipmaster_associate" {
  floating_ip = openstack_networking_floatingip_v2.floating_ip_master.address
  instance_id = openstack_compute_instance_v2.master.id
}
*/


# Generate inventory file for Ansible

resource "local_file" "hosts_cfg" {
  content = templatefile("${path.module}/tr-templates/hosts.tpl",
    {
      master  = openstack_compute_instance_v2.master.*.access_ip_v4
      compute = openstack_compute_instance_v2.compute.*.access_ip_v4
    }
  )
  filename        = "../files/hosts"
  file_permission = 644
}
