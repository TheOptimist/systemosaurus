//
// Time in Words in JSX format

export const refreshFrequency = 1000;

export const command = (dispatch) => { dispatch(new Date()) };

// Twelve is in the zero position as hours is modulo 12
let ones = ["twelve", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten",
  "eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen", "seventeen", "eighteen", "nineteen"];
let tens = [null, null, "twenty", "thirty", "forty", "fifty"];


export const render = () => {
  let now = new Date();

  let hours = now.getHours() % 12;
  let minutes = now.getMinutes();
  
  let minuteWord = "";
  if (minutes  == 0) {
    minuteWord = "o'clock";
  } else if (minutes < 10) {
    minuteWord = "o'" + ones[minutes];
  } else if (minutes < 20) {
    minuteWord = ones[minutes];
  } else {
    let tenWord = tens[minutes.toString().charAt(0)];
    let oneWord = minutes.toString().charAt(1) > 0 ? ones[minutes.toString().charAt(1)] : "";
    minuteWord = tenWord + oneWord;
  }

  return <div>{ones[hours]}<br />{minuteWord}</div>;
};

export const className = {
    width:          "45%",
    top:            "auto",
    bottom:         "1%",
    left:           "auto",
    right:          "1%",
    fontFamily:     "Lato, 'Helvetica Neue', sans-serif",
    color:          "#F5F5F5",
    fontSize:       "5vw",
    fontWeight:     "200",
    letterSpacing:  "0.0em",
    lineHeight:     ".9em",
    textAlign:      "right",
    textTransform:  "uppercase",
};