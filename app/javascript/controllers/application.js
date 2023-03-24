import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = true
window.Stimulus   = application

export { application }


// Import and register all TailwindCSS Components
import {
  Alert,
  Autosave,
  Dropdown,
  Modal,
  Tabs,
  Popover,
  Toggle,
  Slideover,
} from "tailwindcss-stimulus-components";
application.register("alert", Alert);
application.register("autosave", Autosave);
application.register("dropdown", Dropdown);
application.register("modal", Modal);
application.register("tabs", Tabs);
application.register("popover", Popover);
application.register("toggle", Toggle);
application.register("slideover", Slideover);

export default class extends Controller {
  static targets = ["input", "results"];

  connect() {
    this.loadTags();
  }

  loadTags() {
    Rails.ajax({
      url: "/tags",
      type: "GET",
      success: (data) => {
        this.tags = data;
      },
    });
  }

  get tags() {
    return this.data.get("tags").split(",");
  }

  set tags(value) {
    this.data.set("tags", value.join(","));
  }

  search() {
    const query = this.inputTarget.value;
    const results = this.tags.filter((tag) =>
      tag.toLowerCase().includes(query.toLowerCase())
    );
    this.render(results);
  }

  render(results) {
    this.resultsTarget.innerHTML = "";

    if (results.length === 0) {
      return;
    }

    results.forEach((result) => {
      const li = document.createElement("li");
      li.textContent = result;
      this.resultsTarget.appendChild(li);
    });
  }
}