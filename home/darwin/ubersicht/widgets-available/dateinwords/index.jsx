//
// Date in Words in JSX format
// Based heavily on https://github.com/raphaelhanneken/time-in-words

export const refreshFrequency = 1000 * 60 * 5; // five minutes

let ones = [null, "first", "second", "third", "fourth", "fifth",
  "sixth", "seventh", "eighth", "nineth", "tenth",
  "eleventh", "twelfth", "thirteenth", "fourteenth", "fifteenth",
  "sixteenth", "seventeenth", "eighteenth", "nineteenth"];
let tens = [null, null, "twenty", "thirty"];

export const render = ({output, error}) => {

  const now = new Date();
  
  const monthWord = now.toLocaleString("en", { month: 'long' });
  
  const day = now.getDate();
  let dayWord = "";

  if (day < 20) {
    dayWord = ones[day];
  } else {
    const tenWord = tens[day.toString().charAt(0)];
    const oneWord = ones[day.toString().charAt(1)];
    dayWord = tenWord + oneWord;
  }

  return <div>
    <span>{monthWord}</span><br />
    <span>{dayWord}</span>
  </div>;

};

export const className = {
    width:          "45%",
    top:            "auto",
    bottom:         "1%",
    left:           "1%",
    right:          "auto",
    fontFamily:     "Lato, 'Helvetica Neue', sans-serif",
    color:           "#F5F5F5",
    fontSize:       "5vw",
    fontWeight:     "200",
    letterSpacing:  "0.0em",
    lineHeight:     ".9em",
    textTransform:  "uppercase"
};