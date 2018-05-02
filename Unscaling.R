unscaledactual <- test_$`Next Close`*(max(df2)-min(df2))+min(df2) 
unscaledpredicted <- predicted_*(max(df2)-min(df2))+min(df2)