import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "opener", "modal"]

  open() {
    this.modalTarget.style.display = "flex"
  }

  close() {
    this.modalTarget.style.display = "none"
  }

  deselect() {
    this.openerTarget.innerHTML = this.defaultString
    this.close()
  }
  
}