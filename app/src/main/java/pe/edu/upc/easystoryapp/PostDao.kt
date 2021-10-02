package pe.edu.upc.easystoryapp

import androidx.room.*

@Dao
interface PostDao {

    @Query("SELECT * FROM Post")
    fun getAll(): List<Post>

    @Insert
    fun insertPost(vararg posts: Post)

    @Delete
    fun deletePost(vararg posts: Post)

    @Update
    fun updatePost(vararg posts: Post)

}