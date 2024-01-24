## 踩坑紀錄

1. **pytorch3d install failed**: add `-c conda-forge` when installing pytorch, torchvision, and torchaudio
2. **no ffmpeg found**: update ffmpeg
3. **no track_params.pt**: check if pytorch3d is installed successfully

```
conda create --name dfrf python=3.8.11
conda activate dfrf 
conda install pytorch==1.9.0 torchvision==0.10.0 torchaudio==0.9.0 cudatoolkit=10.2 -c pytorch -c conda-forge
conda install -c fvcore -c iopath -c conda-forge fvcore iopath
conda install -c bottler nvidiacub
conda install -c pytorch3d pytorch3d
pip install -r requirements.txt
pip install --ignore-installed PyYAML==5.4.1
conda update ffmpeg
```

**!!Note!!**: 生成的影片是沒有聲音的，需要自行配音；render只會render validation的資料(影片後1/11部分吧，沒記錯的話)，要render全部的話需要手動modify transforms_val.json；改輸入影片解析度感覺起來是不用重train base model(因為測試後效果差不多)，但可能會出現tensor shape不對的問題，pdb那一行會有問題，最後是把1024改成128(解析度改成450時)這樣勉強可以執行

---

# DFRF #
The pytorch implementation for our ECCV2022 paper "Learning Dynamic Facial Radiance Fields for Few-Shot Talking Head Synthesis".

[[Project]](https://sstzal.github.io/DFRF/) [[Paper]](https://arxiv.org/abs/2207.11770) [[Video Demo]](https://www.youtube.com/watch?v=F6fkVNk9bBw)

## Requirements
- Python 3.8.11
- Pytorch 1.9.0
- Pytorch3d 0.5.0
- torchvision 0.10.0

For more details, please refer to the `requirements.txt`. We conduct the experiments with a 24G RTX3090.

- Download `79999_iter.pth` from [here](https://github.com/sstzal/DFRF/releases/tag/file) to `data_util/face_parsing`
- Download `exp_info.npy` from [here](https://github.com/sstzal/DFRF/releases/tag/file) to `data_util/face_tracking/3DMM`
- Download 3DMM model from [Basel Face Model 2009](https://faces.dmi.unibas.ch/bfm/main.php?nav=1-1-0&id=details):

    ```
    cp 01_MorphableModel.mat data_util/face_tracking/3DMM/
    cd data_util/face_tracking
    python convert_BFM.py
    ```
## Dataset
Put the video `${id}.mp4` to `dataset/vids/`, then run the following command for data preprocess.  
```
sh process_data.sh ${id}
```
The data for training the base model is [[here]](https://github.com/sstzal/DFRF/releases/tag/Base_Videos).

## Training
```
sh run.sh ${id}
```
Some pre-trained models are [[here]](https://github.com/sstzal/DFRF/releases/tag/Pretrained_Models).

## Test
Change the configurations in the `rendering.sh`, including the `iters, names, datasets, near and far`.
```
sh rendering.sh
```

## Acknowledgement 
This code is built upon the publicly available code [AD-NeRF](https://github.com/YudongGuo/AD-NeRF) and [GRF](https://github.com/alextrevithick/GRF). Thanks the authors of AD-NeRF and GRF for making their excellent work and codes publicly available. 

## Citation ##
Please cite the following paper if you use this repository in your reseach.

```
@inproceedings{shen2022dfrf,
   author={Shen, Shuai and Li, Wanhua and Zhu, Zheng and Duan, Yueqi and Zhou, Jie and Lu, Jiwen},
   title={Learning Dynamic Facial Radiance Fields for Few-Shot Talking Head Synthesis},
   booktitle={European conference on computer vision},
   year={2022}
}
```
