

variable "mongo_db_atlas" {
    description = "Mongo Atlas details"
    type=object({
        project=string
        database=string
        cluster_type=string
        location=string
    })

    default={
        project="School Supervisor"
        database="main"
        cluster_type="M0"
        location="francecentral"
    }
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