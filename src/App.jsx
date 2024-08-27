import './App.css'
import GoogleSignIn from "./components/login/GoogleSignIn.jsx";


function App() {

    return (
        <div className="container">
            <h1>Welcome to Point2Point</h1>
            <GoogleSignIn/>
        </div>
    )
}

export default App
