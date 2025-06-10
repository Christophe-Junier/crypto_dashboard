import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "hideable" ]

  connect() {
    this.loopsTargets()
  }

  showTargets() {
    this.hideableTargets.forEach(el => {
      el.hidden = false
    });
  }

  hideTargets() {
    this.hideableTargets.forEach(el => {
      el.hidden = true
    });
  }

  toggleTargets() {
    this.hideableTargets.forEach((el) => {
      el.hidden = !el.hidden
    });
  }

  loopsTargets() {
    let length = this.hideableTargets.length
    let buffer = []
    let targets = this.hideableTargets

    window.setInterval( function(){
      targets.forEach((el) => {
        if (!el.classList.contains('d-none')) {
          el.classList.add('d-none');
          buffer = el.id.split("_");
        }
      });

      if (buffer[1] == length) {
        buffer[1] = 1;
      } else {
        buffer[1] = String(Number(buffer[1]) + 1);
      }

      console.log(buffer)
      let next_target_id = buffer[0] + '_' + buffer[1]
      
      targets.forEach((el) => {
        if (el.id == next_target_id) {
          el.classList.remove('d-none');
          el.classList.add('fade-in');
        }
      });
    }, 7000)
  }
}