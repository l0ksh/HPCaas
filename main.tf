# Master node

resource "openstack_compute_instance_v2" "master" {
  name            = "master"
  image_name        = "AlmaLinux-9"
  flavor_name       = "m1.mini"
  key_pair        = "hpcSSH"
  security_groups = ["min-sg"]
  user_data       = file("./user-data.yaml")

  network {
    name = "hpc-private"
  }
}

# Compute node

resource "openstack_compute_instance_v2" "compute" {
  name            = "cn0${count.index}"
  image_name        = "AlmaLinux-9"
  flavor_name       = "m1.mini"
  key_pair        = "hpcSSH"
  security_groups = ["min-sg"]
  user_data       = file("./user-data.yaml")
  count           = var.instance_count

  network {
    name = "hpc-private"
  }
}


# Generate inventory file for Ansible

resource "local_file" "hosts_cfg" {
  content = templatefile("${path.module}/tr-templates/hosts.tpl",
    {
      master  = openstack_compute_instance_v2.master.*.access_ip_v4
      compute = openstack_compute_instance_v2.compute.*.access_ip_v4
    }
  )
  filename = "./hosts.cfg"
}
