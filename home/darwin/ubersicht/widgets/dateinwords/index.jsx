//
// Date in Words in JSX format

export const refreshFrequency = 1000;

export const command = (dispatch) => { dispatch(new Date()) };

let ones = [null, "first", "second", "third", "fourth", "fifth",
  "sixth", "seventh", "eighth", "nineth", "tenth",
  "eleventh", "twelfth", "thirteenth", "fourteenth", "fifteenth",
  "sixteenth", "seventeenth", "eighteenth", "nineteenth"];
let tens = [null, null, "twenty", "thirty"];

export const render = () => {
  let now = new Date();
  let month = now.toLocaleString('en', { month: 'long' });
  let day = now.getDate();

  let dayWord = "";

  if (day < 20) {
    dayWord = ones[day];
  } else {
    const tenWord = tens[day.toString().charAt(0)];
    const oneWord = ones[day.toString().charAt(1)];
    dayWord = tenWord + oneWord;
  }

  return <div>{month}<br />{dayWord}</div>;
};

export const className = {
    width:          "45%",
    top:            "auto",
    bottom:         "1%",
    left:           "1%",
    right:          "auto",
    fontFamily:     "Lato, 'Helvetica Neue', sans-serif",
    color:          "#F5F5F5",
    fontSize:       "5vw",
    fontWeight:     "200",
    letterSpacing:  "0.0em",
    lineHeight:     ".9em",
    textTransform:  "uppercase"
};