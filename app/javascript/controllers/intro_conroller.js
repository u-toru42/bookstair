// intro_controller.js
import { Controller } from "@hotwired/stimulus"
import introJs from 'intro.js'

export default class extends Controller {
  static targets = ["startButton"]

  connect() {
    const intro = introJs()

    intro.setOptions({
      steps: [
        {
          element: document.querySelector(".js-table-bookmark"),
          intro: "ここには、あなたのブックマークが表示されます。",
          position: "bottom"
        },
        {
          element: document.querySelector(".js-start-tour"),
          intro: "こちらのボタンをクリックすると、ツアーが始まります。",
          position: "top"
        },
        {
          element: document.querySelector("#error_explanation"),
          intro: "ここには、エラーメッセージが表示されます。",
          position: "right"
        }
      ]
    })

    this.startTour = () => {
      intro.start()
    }
  }

  start() {
    this.startButtonTarget.addEventListener('click', this.startTour)
  }

  disconnect() {
    this.startButtonTarget.removeEventListener('click', this.startTour)
  }
}
