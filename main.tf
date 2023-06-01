resource "genesyscloud_integration_action" "action" {
    name           = var.action_name
    category       = var.action_category
    integration_id = var.integration_id
    secure         = var.secure_data_action
    
    contract_input  = jsonencode({
        "$schema" = "http://json-schema.org/draft-04/schema#",
        "description" = "A Contact Id based Request",
        "properties" = {
            "contactId" = {
                "description" = "Contact to relate the case to",
                "type" = "string"
            },
            "description" = {
                "description" = "Description for the case",
                "type" = "string"
            },
            "subject" = {
                "description" = "Subject of the case",
                "type" = "string"
            }
        },
        "required" = [
            "description",
            "contactId",
            "subject"
        ],
        "title" = "ContactIdRequest",
        "type" = "object"
    })
    contract_output = jsonencode({
        "$schema" = "http://json-schema.org/draft-04/schema#",
        "id" = "http://example.com/example.json",
        "properties" = {
            "errors" = {
                "id" = "/properties/errors",
                "items" = {},
                "type" = "array"
            },
            "id" = {
                "id" = "/properties/id",
                "type" = "string"
            },
            "success" = {
                "id" = "/properties/success",
                "type" = "boolean"
            }
        },
        "required" = [
            "errors",
            "id",
            "success"
        ],
        "type" = "object"
    })
    
    config_request {
        request_template     = "{\"ContactId\": \"$${input.contactId}\",\"Subject\": \"$${input.subject}\",\"Description\": \"$${input.description}\",\"Origin\":\"Email\", \"Status\": \"New\"}"
        request_type         = "POST"
        request_url_template = "/services/data/v54.0/sobjects/Case/"
        
    }

    config_response {
        success_template = "$${rawResult}"
         
               
    }
}