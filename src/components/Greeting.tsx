import { useState } from "preact/hooks";

interface Props {
  message: string[];
}

export default function Greeting({ message }: Props) {
  const [greeting, setGreeting] = useState(0);

  const randomMessage = () => Math.floor(Math.random() * message.length);

  return (
    <div>
      <h3>{message[greeting]}</h3>
      <button
        class="button"
        onClick={() => {
          setGreeting(randomMessage());
        }}
      >
        Refresh
      </button>
    </div>
  );
}
