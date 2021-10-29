package pe.edu.upc.easystoryapp

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Button
import android.widget.EditText
import android.widget.Toast

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        val etUsername = findViewById<EditText>(R.id.etUsername)
        val etPassword = findViewById<EditText>(R.id.etPassword)

        val btnLogin = findViewById<Button>(R.id.btnLogin)
        val btnSignUp = findViewById<Button>(R.id.btnSignUp)

        btnLogin.setOnClickListener {
            verifyData(etUsername.text.toString(), etPassword.text.toString())
        }


    }

    private fun verifyData(etUsername: String, etPassword: String){

        if (etUsername.equals("admin") and etPassword.equals("admin")){
            Toast.makeText(applicationContext, "¡Inicio de sesión correcto!", Toast.LENGTH_LONG).show()
            val postActivity = Intent(this, PostActivity::class.java)
            startActivity(postActivity)
        } else {
            Toast.makeText(applicationContext, "Nombre de usuario o contraseña inválidos", Toast.LENGTH_LONG).show()
        }

    }

}