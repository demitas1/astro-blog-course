import {useState} from "preact/hooks";

export default function Greeting({ message }) {
  const [greeting, setGreeting] = useState(0);

  const randomMessage = () => Math.floor(Math.random() * message.length)

  return (
    <div>
      <h3>{message[greeting]}</h3>
      <button class="button" onClick={
        () => {
          setGreeting(randomMessage())
        }
      }> Refresh </button>
    </div>
  );
}
