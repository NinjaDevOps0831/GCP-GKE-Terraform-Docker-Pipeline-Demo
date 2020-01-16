/**
 * Copyright 2019 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

variable "host_project_id" {
  description = "Project id of the shared VPC host project."
}

# passed-in values can be dynamic, so variables used in count need to be separate

variable "service_project_num" {
  description = "Number of service projects that will be attached to the Shared VPC."
  default     = 0
}

variable "service_project_ids" {
  description = "Ids of the service projects that will be attached to the Shared VPC."
  type        = "list"
}

variable "host_subnets" {
  description = "List of subnet names on which to grant network user role."
  default     = []
}

variable "host_subnet_regions" {
  description = "List of subnet regions, one per subnet."
  default     = []
}

variable "host_subnet_users" {
  description = "Map of comma-delimited IAM-style members to which network user roles for subnets will be assigned."
  default     = {}
}

variable "host_service_agent_role" {
  description = "Assign host service agent role to users in host_service_agent_users variable."
  default     = false
}

variable "host_service_agent_users" {
  description = "List of IAM-style users that will be granted the host service agent role on the host project."
  default     = []
}
