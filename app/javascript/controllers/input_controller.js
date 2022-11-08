import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "output" ]

  setValue(event) {
    const element = event.target // get input element
    this.outputTarget.value = element.dataset.value // set hidden value
  }

}