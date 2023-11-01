terraform {
  required_version = "~> 1.5.3"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.20.1"
    }

    local = {
      source  = "hashicorp/local"
      version = "2.4.0"
    }
  }
/*

  }
  backend "local" {
    path = "tfstate/mytfstate.tfstate"
    
  }
*/

backend "s3" {
  bucket = "mp-tfstate-mp"
  key = "state/state1"
  region = "us-east-1" 

}

}

  
