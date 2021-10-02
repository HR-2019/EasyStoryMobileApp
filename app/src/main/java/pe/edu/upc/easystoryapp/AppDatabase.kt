package pe.edu.upc.easystoryapp

import android.content.Context
import androidx.room.Database
import androidx.room.Room
import androidx.room.RoomDatabase

@Database(entities = arrayOf(Post::class), version = 1)
abstract class AppDatabase: RoomDatabase() {

    abstract fun getDao() : PostDao

    companion object{
        private var INSTANCE: AppDatabase? = null

        fun getInstance(context: Context): AppDatabase{
            if (INSTANCE == null){
                INSTANCE = Room.databaseBuilder(context, AppDatabase::class.java, "app.db")
                    .allowMainThreadQueries()
                    .build()
            }

            return INSTANCE as AppDatabase

        }
    }

}