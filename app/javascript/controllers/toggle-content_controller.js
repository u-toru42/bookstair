import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = [ "bookmarksSection", "booksSection" ]
  static classes = [ "hidden" ]

  connect() {
    this.showBookmarksSection()
  }

  toggle() {
    if (this.bookmarksSectionTarget.classList.contains(this.hiddenClass)) {
      this.showBookmarksSection()
    } else {
      this.showBooksSection()
    }
  }

  showBookmarksSection() {
    this.booksSectionTarget.classList.add(this.hiddenClass)
    this.bookmarksSectionTarget.classList.remove(this.hiddenClass)
  }

  showBooksSection() {
    this.bookmarksSectionTarget.classList.add(this.hiddenClass)
    this.booksSectionTarget.classList.remove(this.hiddenClass)
  }
}
