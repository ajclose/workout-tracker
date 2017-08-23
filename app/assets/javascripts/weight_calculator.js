document.addEventListener("DOMContentLoaded", function(event) {
  const weights = []
  let barWeight;

  const weightSelections = document.querySelectorAll('input[name="weight"]')
  for (var i = 0; i < weightSelections.length; i++) {
    const weightSelection = weightSelections[i]
    weightSelection.addEventListener("change", function() {
      if (!this.checked) {
        const index = weights.indexOf(this.value)
        weights.splice(index, 1)
        console.log(weights);
      } else {
        weights.push(this.value)
        console.log(weights);
      }
    })
  }

  const barWeightSelections = document.querySelectorAll('input[name="barWeight"]')
  for (var i = 0; i < barWeightSelections.length; i++) {
    const barWeightSelection = barWeightSelections[i]
    if (barWeightSelection.checked) {
      barWeight = barWeightSelection.value
      console.log(barWeight);
    }
    barWeightSelection.addEventListener("change", function() {
      barWeight = barWeightSelection.value
      console.log(barWeight);
    })
  }

  const platesForm = document.querySelector('form.plates')
  platesForm.addEventListener("submit", function(event) {
    event.preventDefault()
    const totalWeight = document.querySelector('input[name="totalWeight"]').value
    let plates = calcWeights(totalWeight, weights, barWeight)
    for(var weight in plates) {
      const html = `
      <p>You need ${plates[weight]} ${weight} lb plates</p>
      `
      document.querySelector(".container").insertAdjacentHTML("beforeend", html)
    }
  })

  function calcWeights(totalWeight, weights, barWeight) {
    let remainingWeight = totalWeight -  barWeight
    let plates = {}
    for (let i=0; i<weights.length; i++) {
      const weight = weights[i]
      const doubleWeight = weight * 2
      if(remainingWeight >= doubleWeight) {
        plates[weight] = Math.floor(remainingWeight/doubleWeight) * 2
        remainingWeight = remainingWeight%doubleWeight
      }
    }
    return plates
  }

  plates = calcWeights(165, weights, barWeight)

  for(var weight in plates) {
    console.log(`You need ${plates[weight]} ${[weight]} lb plates`);
  }

})
