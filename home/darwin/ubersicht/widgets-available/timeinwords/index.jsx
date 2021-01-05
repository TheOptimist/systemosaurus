//
// Time in Words in JSX format
// Based heavily on https://github.com/raphaelhanneken/time-in-words

export const refreshFrequency = 1000; // one second

let ones = [null, "one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten",
  "eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen", "seventeen", "eighteen", "nineteen"];
let tens = [null, null, "twenty", "thirty", "forty", "fifty"];

export const render = ({output, error}) => {

  const now = new Date();
  
  const hour   = now.getHours() % 12;
  const hourWord = hour === 0 ? ones[12]: ones[hour];
  
  const minute = now.getMinutes();
  let minuteWord = "";

  if (minute == 0) {
    minuteWord = "o'clock";
  } else if (minute < 10) {
    minuteWord = "o'" + ones[minute];
  } else if (minute < 20) {
    minuteWord = ones[minute];
  } else {
    let tenWord = tens[minute.toString().charAt(0)];
    let oneWord = minute.toString().charAt(1) > 0 ? ones[minute.toString().charAt(1)] : "";
    minuteWord = tenWord + oneWord;
  }

  return <div>
    <span>{hourWord}</span><br />
    <span>{minuteWord}</span>
  </div>;

};

export const className = {
    width:           "45%",
    top:             "auto",
    bottom:          "1%",
    left:            "auto",
    right:           "1%",
    fontFamily:     "Lato, 'Helvetica Neue', sans-serif",
    color:           "#F5F5F5",
    fontSize:       "5vw",
    fontWeight:     "200",
    letterSpacing:  "0.0em",
    lineHeight:     ".9em",
    textAlign:      "right",
    textTransform:  "uppercase",
};