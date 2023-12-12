import imageio, os

fileList = []
path = "./dataset/finetune_models/Obama_val_base450_cnn2_25fps/renderonly_path_649997/"

for file in os.listdir(path):
    if file.endswith(".png"):
        complete_path = path + file
        fileList.append(complete_path)

fileList.sort()
fileList.sort(key=lambda x:x[:-4])

print(len(fileList))

kargs = { 'macro_block_size': None }
writer = imageio.get_writer(path+'Obama_cnn2_25fps.mp4', fps=25, quality=8, **kargs)

for im in fileList:
    writer.append_data(imageio.imread(im))
writer.close()
