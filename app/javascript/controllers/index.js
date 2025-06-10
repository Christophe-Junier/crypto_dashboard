// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "controllers/application"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
import VisibilityController from "./visibility_controller"
application.register("visibility", VisibilityController)
eagerLoadControllersFrom("controllers", application)
