import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "opener", "modal", "user", "output" ]
  static defaultString

  connect() {
    this.defaultString = this.openerTarget.innerHTML
  }

  open() {
    this.modalTarget.style.display = "flex"
  }

  close() {
    this.modalTarget.style.display = "none"
  }

  select(event) {
    const element = event.target
    this.close()
    this.openerTarget.innerHTML = element.innerHTML
    this.outputTarget.value = element.dataset.id
    scroll(0, 0)
  }

  deselect() {
    console.log(this.defaultString)
    this.openerTarget.innerHTML = this.defaultString
    this.close()
  }
  
}