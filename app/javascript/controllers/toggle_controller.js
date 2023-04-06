import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["bars", "xmark", "menu"]

  toggle(event) {
    this.barsTarget.classList.toggle("hidden")
    this.xmarkTarget.classList.toggle("hidden")
    this.menuTarget.classList.toggle("translate-x-full")
  }
}