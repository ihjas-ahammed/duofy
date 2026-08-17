# Duofy Reusable Lesson Format: Detection Metrics (IoU, Non-Maximum Suppression, and mAP)

**Target Topic:** `03_Computer_Science_and_IT / 06_Artificial_Intelligence_and_Machine_Learning / Computer_Vision / Object_Detection_YOLO_RCNN`  
**Lesson Format Type:** `detection_metrics_iou_non_maximum_suppression_and_map`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify spatial overlap metrics, duplicate bounding box suppression, and comprehensive multi-threshold evaluation protocols in object detection (Mark Everingham et al. PASCAL VOC Challenge; Tsung-Yi Lin et al. MS COCO 2014; Navaneeth Bodla et al. 2017 Soft-NMS): master **Intersection over Union ($\mathbf{\text{IoU} = \frac{\text{Area of Overlap } |A \cap B|}{\text{Area of Union } |A \cup B|}}$)**, master greedy **Non-Maximum Suppression (NMS)** and **Soft-NMS** ($s_i \leftarrow s_i e^{-\frac{\text{IoU}^2}{\sigma}}$) which recursively suppress redundant overlapping candidate boxes while preserving distinct nearby objects, analyze **Precision-Recall Curves** in object detection (where True Positives require $\text{IoU} \ge \text{threshold}$ with ground truth), derive **Average Precision (AP - 11-point interpolation or all-point AUC)**, and master the standard **COCO Mean Average Precision Benchmark ($\mathbf{\text{mAP}@[0.50:0.05:0.95]}$)**, interacting with live Bounding Box IoU calculation, NMS deduplication, and Precision-Recall curve simulator widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | IoU Set Formula $\frac{|A \cap B|}{|A \cup B|}$, Greedy NMS Algorithm, & COCO mAP@[.50:.95] Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Detection Metric / Post-Processing Component & Mathematical Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Why the COCO Benchmark Evaluates mAP Across 10 IoU Thresholds [0.50:0.05:0.95] Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | The Bounding Box Geometric Overlap Metric Calculated as Overlap Divided by Union Is ___ (IoU) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Object Detection Studio: IoU Evaluator, Greedy NMS, & Precision-Recall Curve Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "detection_metrics_iou_non_maximum_suppression_and_map",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is IoU, how does Non-Maximum Suppression (NMS) clean up bounding boxes, and how is COCO mAP calculated?",
      "blankAnswer": "Detection Metrics (VOC / COCO Standards): (1) INTERSECTION OVER UNION (IoU): IoU(A, B) = Area(A &cap; B) / Area(A &cup; B) = Area(A &cap; B) / [Area(A) + Area(B) - Area(A &cap; B)] &isin; [0, 1]. A predicted box is a True Positive (TP) if IoU >= threshold (typically 0.5) with a ground truth box and class matches. (2) GREEDY NMS PIPELINE: Sort all predicted boxes by confidence score. Pick the highest scoring box B_max and add to final detections. Discard all remaining boxes that have IoU(B_max, B_i) > NMS_threshold (e.g. 0.45). Repeat until no boxes remain. (3) COCO mAP@[.50:.95]: Evaluates Mean Average Precision across 10 IoU thresholds from 0.50 to 0.95 with step 0.05 (mAP_50, mAP_55, ..., mAP_95) and computes the grand average across all object classes and all thresholds!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each Object Detection Metric Construct to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Intersection over Union (IoU)", "right": "Measures spatial overlap ratio between predicted bounding box and ground-truth annotation" },
        { "left": "Greedy NMS Algorithm", "right": "Iterative deduplication pruning redundant bounding boxes that heavily overlap the top-confidence prediction" },
        { "left": "Soft-NMS (Bodla et al. 2017)", "right": "Continuous Gaussian decay of box scores (s * exp(-IoU^2 / sigma)) preventing accidental deletion of occluded objects" },
        { "left": "COCO mAP@[0.5:0.95]", "right": "Comprehensive metric averaging AP across 10 discrete IoU thresholds to reward tight boundary localization" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Why did the Microsoft COCO benchmark introduce mAP@[0.50:0.05:0.95] (averaging AP across 10 IoU thresholds from 0.50 to 0.95) rather than relying exclusively on the classic PASCAL VOC metric of mAP@0.50?",
      "options": [
        { "text": "The classic PASCAL VOC metric of mAP@0.50 only requires a predicted bounding box to have a loose 50% overlap with the ground truth to be counted as a perfect True Positive, completely failing to differentiate between a sloppy, loosely positioned box and a pixel-perfect, tightly localized bounding box; COCO mAP@[0.50:0.05:0.95] computes Average Precision across 10 progressively stringent IoU thresholds (0.50, 0.55, ..., 0.95), heavily penalizing poor localization and forcing models to achieve sub-pixel spatial boundary accuracy", "isCorrect": true, "explanation": "Correct! This is Tsung-Yi Lin et al.'s motivation when establishing the Microsoft COCO Benchmark (Lin et al. ECCV 2014 *Microsoft COCO: Common Objects in Context*). 1. **The Flaw of PASCAL VOC mAP@0.50:** - Under $\\text{IoU} = 0.50$, a bounding box that covers only half of a person's body and cuts off their head is counted as a **$100\\%$ perfect detection**! - A model with sloppy, oversized boxes gets the exact same score as a model with millimeter-precise boundaries. 2. **The COCO 10-Threshold Standard:** - COCO evaluates AP at $\\text{IoU} = [0.50, 0.55, 0.60, 0.65, 0.70, 0.75, 0.80, 0.85, 0.90, 0.95]$. - At $\\text{IoU} = 0.95$, the predicted box must align **almost perfectly down to the single pixel** with the ground truth to earn a True Positive point! - The metric $\\text{mAP} = \\frac{1}{10} \\sum_{t=1}^{10} \\text{AP}_{\\text{IoU}_t}$ rewards both recognition recall AND razor-sharp spatial localization. 3. **The Result:** COCO pushed the entire AI field from coarse blob finding to surgical bounding box and instance segmentation precision!" },
        { "text": "Because mAP@0.50 can only be evaluated on images containing 1 object", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because COCO datasets only contain grayscale images", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because evaluating 10 thresholds runs 10 times faster than evaluating 1 threshold", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The geometric overlap metric measuring area of overlap divided by area of union is ___.",
      "blankAnswer": "IoU",
      "blankDistractors": ["NMS", "AUC", "ROC"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Object Detection Studio: IoU, NMS & mAP",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Detection Evaluation Studio</h3><p>Raw Predictions: <b style=\"color:#38bdf8;\">3 Overlapping Bounding Boxes on 1 Dog</b></p><div style=\"display:flex; gap:6px;\"><button id=\"btnIou\" style=\"padding:6px 10px; background:#3b82f6; color:white; border:none; border-radius:4px; cursor:pointer;\">1. Calculate IoU Matrix</button><button id=\"btnNms\" style=\"padding:6px 10px; background:#f59e0b; color:white; border:none; border-radius:4px; cursor:pointer;\">2. Run Greedy NMS</button><button id=\"btnMap\" style=\"padding:6px 10px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer; font-weight:bold;\">3. Evaluate COCO mAP@[.5:.95]</button></div><div id=\"detLog\" style=\"margin-top:12px; border:1px solid #475569; padding:10px; border-radius:6px; min-width:340px; font-family:monospace; color:#fbbf24;\">Click step 1 to compute bounding box IoU...</div><script>document.getElementById('btnIou').onclick=()=>{document.getElementById('detLog').innerHTML='<b>1. INTERSECTION OVER UNION (IoU):</b><br>• Box A (Conf: 0.94) vs Ground Truth: <b style=\"color:#10b981;\">IoU = 0.88</b><br>• Box B (Conf: 0.78) vs Box A: <b style=\"color:#f59e0b;\">IoU = 0.72</b><br>• Box C (Conf: 0.61) vs Box A: <b style=\"color:#f59e0b;\">IoU = 0.65</b>';}; document.getElementById('btnNms').onclick=()=>{document.getElementById('detLog').innerHTML='<b>2. GREEDY NON-MAXIMUM SUPPRESSION:</b><br>• Kept: <b>Box A (Conf 0.94)</b> [Highest confidence]<br>• Suppressed Box B (IoU 0.72 > 0.45) &rarr; <b style=\"color:#ef4444;\">PRUNED!</b><br>• Suppressed Box C (IoU 0.65 > 0.45) &rarr; <b style=\"color:#ef4444;\">PRUNED!</b><br>🎉 <b style=\"color:#10b981;\">Exactly 1 clean bounding box remains!</b>';}; document.getElementById('btnMap').onclick=()=>{document.getElementById('detLog').innerHTML='<b>3. COCO BENCHMARK EVALUATION:</b><br>• mAP@0.50 = 1.00 (IoU 0.88 >= 0.50: TP)<br>• mAP@0.75 = 1.00 (IoU 0.88 >= 0.75: TP)<br>• mAP@0.90 = 0.00 (IoU 0.88 < 0.90: FP)<br>🏆 <b style=\"color:#10b981;\">mAP@[.50:.95] = 0.800 (High-Precision Detection!)</b>'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
