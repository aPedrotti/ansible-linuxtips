output "app_ip" {
  value = "${aws_instance.app[*].public_ip}"
}
output "app_name" {
  value = "${aws_instance.app[*].public_dns}"
}

resource "local_file" "AnsibleInventory" {
  content = templatefile("inventory.tmpl",
  {
    app-name = aws_instance.app[*].public_dns,
    app-ip = aws_instance.app[*].public_ip
  }
  )
  filename = "inventory"
}