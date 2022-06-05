

variable "mongo_db_atlas" {
    description = "Mongo Atlas details"
    type=object({
        organization=string
        project=string
        database=string
        cluster=object({
            name=string
            type=string
        })
        location=string
    })
}

variable "azure"{
    description = "Azure details"
    type=object({
        location=string
        rg_name=string
    })
    default={
        location="francecentral"
        rg_name="school-supervisor"
    }
}