package pe.edu.upc.easystoryapp
import androidx.room.ColumnInfo
import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity
class Post (

        @PrimaryKey(autoGenerate = true)
        val id: Int,

        @ColumnInfo
        val userId: Int,

        @ColumnInfo
        val title: String,

        @ColumnInfo
        val description: String,

        @ColumnInfo
        val content: String

)