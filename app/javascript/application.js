// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"

// Turbo.session.drive = false;

const application = Application.start()
application.register("toggle", ToggleController)

