#!/usr/bin/env python
# coding: utf-8

# In[ ]:


import glob
import os
import pandas as pd
import matplotlib.pyplot as plt


# In[ ]:


data_dir = '../out/tables';
df = None;
with os.scandir(data_dir) as dirs:
    for entry in dirs:
        data_files = glob.glob(os.path.join(data_dir, entry.name, "*.txt"))
        df2 = pd.concat(map(lambda file: pd.read_csv(file, sep='\t'), data_files))
        df2['executable'] = entry.name;
        df2.set_index('num_datapoints', inplace=True, drop=False)
        df2.sort_index(inplace=True)
        if df is None:
            df = df2
        else:
            df = df.append(df2, ignore_index=False)
print(df)


# In[ ]:


for col in df.columns.values:
    if col == 'executable' or col == 'num_datapoints':
        continue
    fig, ax = plt.subplots()
    for exe in df['executable'].unique():
        ( 
            df
            .where(df['executable'] == exe)
            .plot
            .line(
                ylabel=col,
                y=col,
                use_index=True,
                ax=ax,
                logx=True,
                label=exe
            )
        )
    filename = col.replace(' ', '_') + ".png"
    fig.savefig("../out/charts/" + filename)

