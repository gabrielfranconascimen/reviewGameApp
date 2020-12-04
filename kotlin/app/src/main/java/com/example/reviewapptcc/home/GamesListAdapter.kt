package com.example.reviewapptcc.home

import android.graphics.drawable.Drawable
import android.os.AsyncTask
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.core.content.ContextCompat
import androidx.recyclerview.widget.RecyclerView
import com.bumptech.glide.Glide
import com.example.reviewapptcc.R
import com.example.reviewapptcc.utils.RemoteCloudStorage
import com.squareup.picasso.Picasso
import kotlinx.android.synthetic.main.item_list_game.view.*
import java.util.concurrent.Executor

class GamesListAdapter(val callback: (GameModel) -> Unit) : RecyclerView.Adapter<GamesListAdapter.ViewHolder>() {

    private val data = mutableListOf<GameModel>()

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        val view = LayoutInflater.from(parent.context).inflate(R.layout.item_list_game, parent, false)
        return ViewHolder(view)
    }

    override fun getItemCount(): Int {
        return data.size
    }

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        holder.bind(data[position], callback)
    }

    fun setGames(games: List<GameModel>) {
        data.clear()
        data.addAll(games)
        notifyDataSetChanged()
    }


    class ViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {

        fun bind(item: GameModel, callback: (GameModel) -> Unit) {
            itemView.tvGameName.text = item.name

            RemoteCloudStorage.getImage(item.thumbnail) {
                Picasso.get()
                    .load(it)
                    .into(itemView.gameThumbnail)
            }

            itemView.setOnClickListener {
                callback.invoke(item)
            }
        }
    }
}