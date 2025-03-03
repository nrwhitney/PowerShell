Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form
$form.Size = New-Object System.Drawing.Size(230,150)
$form.StartPosition = 'CenterScreen'
$form.FormBorderStyle = 'Fixed3D'
$form.MaximizeBox = $False
$form.MinimizeBox = $False
$form.Text = 'Time Difference Calculator'

function New-Label($x, $y, $text, $height=20, $width=60) {
    $label = New-Object System.Windows.Forms.Label
    $label.Location = New-Object System.Drawing.Point($x,$y)
    $label.Size = New-Object System.Drawing.Size($width,$height)
    $label.Text = $text
    $form.Controls.Add($label)
}

function New-TextBox($x, $y, $height=22, $width=128) {
    $textBox = New-Object System.Windows.Forms.TextBox
    $textBox.Location = New-Object System.Drawing.Point($x,$y)
    $textBox.Size = New-Object System.Drawing.Size($width,$height)
    $form.Controls.Add($textBox)
    return $textBox
}
function Get-Span {
    if($startTime.Text -eq "" -or $endTime.Text -eq ""){
        $timeDiff.Text = ""
     }else{
        try {
            $diff = New-TimeSpan -Start $startTime.Text -End $endTime.Text
            $timeDiff.Text =  $diff.ToString("dd'd 'hh'h 'mm'm 'ss's 'fff'ms'")
        }
        catch {
            $timeDiff.Text = "Invalid format.."
        }
    }
}

New-Label 10 18 'Start time:'
New-Label 12 50 'End time:'
New-Label 10 82 'Difference:'
$startTime = New-TextBox 74 15
$startTime.Add_TextChanged({Get-Span})
$endTime = New-TextBox 74 47
$endTime.Add_TextChanged({Get-Span})
$timeDiff = New-TextBox 74 79
$timeDiff.ReadOnly = $true
$form.Topmost = $true
$form.ShowDialog()
$form.Dispose()