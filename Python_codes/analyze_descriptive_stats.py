import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
# Load data from a CSV file with specified encoding
data = pd.read_csv("E:/Data_Analysis/Data_Analytics_Projects/Capstone_Project_SpotifyTrendsAnalyzer/SpotifyTrendsAnalyzer/Data_set/spotify_songs_cleaned.csv", encoding='latin1')

print(data.head())

#Summary statistics
summary_stats = data.describe()
print(summary_stats)
# Individual statisktics
##mean_value = data['danceability'].mean()
#median_value = data['column_name'].median()
#std_deviation = data['column_name'].std()

df = pd.DataFrame(data)





# Assuming your DataFrame is named 'df'
# Group by 'track_artist' and count the number of tracks for each artist
artist_track_counts = df['track_artist'].value_counts()

grouped_data = df.groupby(['track_artist', 'released_year']).mean()['track_popularity'].reset_index()

# Pivot the data to have artists as rows, years as columns, and average popularity as values
pivot_data = grouped_data.pivot(index='track_artist', columns='released_year', values='track_popularity')

# Plot a bar chart for average popularity of each artist over the years
pivot_data.plot(kind='bar', figsize=(15, 8))
plt.title('Average Popularity of Artists Over the Years')
plt.xlabel('Artist')
plt.ylabel('Average Popularity')
plt.legend(title='Year', bbox_to_anchor=(1.05, 1), loc='upper left')

plt.show()






