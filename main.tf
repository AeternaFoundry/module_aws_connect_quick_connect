resource "aws_connect_quick_connect" "connect_quick_connects" {
  for_each = var.connect_quick_connects

  instance_id = each.value.instance_id
  name        = each.value.name
  description = each.value.description
  region      = each.value.region
  tags        = each.value.tags
  tags_all    = each.value.tags_all

  quick_connect_config {
    dynamic "phone_config" {
      for_each = each.value.quick_connect_config.phone_config != null ? each.value.quick_connect_config.phone_config : []
      content {
        phone_number = phone_config.value.phone_number
      }
    }
    dynamic "queue_config" {
      for_each = each.value.quick_connect_config.queue_config != null ? each.value.quick_connect_config.queue_config : []
      content {
        contact_flow_id = queue_config.value.contact_flow_id
        queue_id        = queue_config.value.queue_id
      }
    }
    quick_connect_type = each.value.quick_connect_config.quick_connect_type
    dynamic "user_config" {
      for_each = each.value.quick_connect_config.user_config != null ? each.value.quick_connect_config.user_config : []
      content {
        contact_flow_id = user_config.value.contact_flow_id
        user_id         = user_config.value.user_id
      }
    }
  }
}

