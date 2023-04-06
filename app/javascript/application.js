// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"


const application = Application.start()
application.register("toggle", ToggleController)
