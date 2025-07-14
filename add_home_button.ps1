$homeButton = @"
    
    <!-- 回到首页按钮 -->
    <div style="position: fixed; bottom: 30px; right: 30px; z-index: 1000;">
        <a href="../index.html" 
           style="display: inline-flex; align-items: center; gap: 8px; padding: 12px 20px; 
                  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); 
                  color: white; text-decoration: none; border-radius: 50px; 
                  font-weight: 600; box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3); 
                  transition: all 0.3s ease; font-size: 14px;">
            <span style="font-size: 16px;">🏠</span>
            回到首页
        </a>
    </div>
    
    <style>
        /* 回到首页按钮悬停效果 */
        div[style*="position: fixed"] a:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(102, 126, 234, 0.4);
        }
        
        /* 移动端适配 */
        @media (max-width: 768px) {
            div[style*="position: fixed"] {
                bottom: 20px !important;
                right: 20px !important;
            }
            
            div[style*="position: fixed"] a {
                padding: 10px 16px !important;
                font-size: 12px !important;
            }
        }
    </style>
</body>
</html>
"@

# 需要处理的文件列表
$files = @(
    "calibration\monocular_laser_plane_calibration.html",
    "calibration\radial_constraint_calibration.html",
    "fpga\fpga_clb_guide.html",
    "fpga\fpga_vs_software.html",
    "slam\point_cloud_registration_guide.html",
    "slam\slam_tech_overview.html",
    "structured_light_algo\gray_code_tutorial.html",
    "structured_light_algo\phase_shift_graycode.html",
    "structured_light_algo\structured_light_3d_measurement.html",
    "structured_light_algo\updated_laser_triangulation.html"
)

foreach ($file in $files) {
    $fullPath = "f:\vscode_explore\3d_camera_website\$file"
    if (Test-Path $fullPath) {
        $content = Get-Content $fullPath -Raw
        
        # 检查是否已经有回到首页按钮
        if ($content -notmatch "回到首页") {
            # 替换 </body></html> 为包含回到首页按钮的内容
            $content = $content -replace "</body>\s*</html>", $homeButton
            Set-Content $fullPath $content -NoNewline
            Write-Host "已为 $file 添加回到首页按钮"
        } else {
            Write-Host "$file 已经有回到首页按钮"
        }
    } else {
        Write-Host "文件不存在: $file"
    }
}

Write-Host "批量处理完成！"
