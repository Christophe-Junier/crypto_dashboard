// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "controllers/application"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
import CollapseController from "./collapse_controller"
application.register("collapse", CollapseController)
eagerLoadControllersFrom("controllers", application)
