variable "connect_quick_connects" {
  description = <<EOT
Map of connect_quick_connects, attributes below
Required:
    - instance_id
    - name
    - quick_connect_config (block):
        - phone_config (optional, block):
            - phone_number (required)
        - queue_config (optional, block):
            - contact_flow_id (required)
            - queue_id (required)
        - quick_connect_type (required)
        - user_config (optional, block):
            - contact_flow_id (required)
            - user_id (required)
Optional:
    - description
    - region
    - tags
    - tags_all
EOT

  type = map(object({
    instance_id = string
    name        = string
    description = optional(string)
    region      = optional(string)
    tags        = optional(map(string))
    tags_all    = optional(map(string))
    quick_connect_config = object({
      phone_config = optional(list(object({
        phone_number = string
      })))
      queue_config = optional(list(object({
        contact_flow_id = string
        queue_id        = string
      })))
      quick_connect_type = string
      user_config = optional(list(object({
        contact_flow_id = string
        user_id         = string
      })))
    })
  }))
  # Note: 3 additional provider-side validators are enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

