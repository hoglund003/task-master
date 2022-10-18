import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "opener", "modal", "task", "output" ]
  static defaultString

  connect() {
    this.defaultString = this.openerTarget.innerHTML
  }

  open(event) {
    this.modalTarget.style.display = "flex"
    const element = event.target
    this.outputTarget.value = element.dataset.id
    scroll(0, 0)
  }

  close() {
    this.modalTarget.style.display = "none"
  }

  deselect() {
    console.log(this.defaultString)
    this.openerTarget.innerHTML = this.defaultString
    this.close()
  }
  
}